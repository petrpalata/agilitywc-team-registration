module StaffMembersHelper
    def role_select(form, options = {})
        form.select(:role_type, possible_roles.map { |k, v| [v, k] }, options)
    end

    def possible_roles
        {
            1 => I18n.t('staff_members.model.teamleader'),
            2 => I18n.t('staff_members.model.first_assistant'),
            3 => I18n.t('staff_members.model.second_assistant'),
            4 => I18n.t('staff_members.model.physiotherapist'),
            5 => I18n.t('staff_members.model.other')
        }
    end
end
