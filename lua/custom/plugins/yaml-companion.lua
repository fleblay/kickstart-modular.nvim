return {
  {
    'someone-stole-my-name/yaml-companion.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'b0o/schemastore.nvim',
    },
    config = function()
      local cfg = require('yaml-companion').setup {
        -- detect k8s schemas based on file content
        builtin_matchers = {
          kubernetes = { enabled = true },
        },
        -- schemas available in Telescope picker
        schemas = {
          -- Usually K8s CRDS
          -- not loaded automatically, manually select with
          -- :Telescope yaml_schema
          {
            name = 'Argo CD Application',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
          },
          {
            name = 'SealedSecret',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json',
          },
          {
            name = 'Traefik ingressroute',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/traefik.io/ingressroute_v1alpha1.json',
          },
          {
            name = 'Traefik ingressroutetcp',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/traefik.io/ingressroutetcp_v1alpha1.json',
          },
          {
            name = 'Traefik middleware',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/traefik.io/middleware_v1alpha1.json',
          },
          {
            name = 'Traefik middlewaretcp',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/traefik.io/middlewaretcp_v1alpha1.json',
          },
          {
            name = 'monitoring.coreos.com alertmanager',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/alertmanager_v1.json',
          },
          {
            name = 'monitoring.coreos.com alertmanagerconfig',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/alertmanagerconfig_v1alpha1.json',
          },
          {
            name = 'monitoring.coreos.com podmonitor',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/podmonitor_v1.json',
          },
          {
            name = 'monitoring.coreos.com probe',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/probe_v1.json',
          },
          {
            name = 'monitoring.coreos.com prometheus',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/prometheus_v1.json',
          },
          {
            name = 'monitoring.coreos.com prometheusagent',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/prometheusagent_v1alpha1.json',
          },
          {
            name = 'monitoring.coreos.com prometheusrule',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/prometheusrule_v1.json',
          },
          {
            name = 'monitoring.coreos.com scrapeconfig',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/scrapeconfig_v1alpha1.json',
          },
          {
            name = 'monitoring.coreos.com servicemonitor',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/servicemonitor_v1.json',
          },
          {
            name = 'monitoring.coreos.com thanosruler',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/thanosruler_v1.json',
          },
          -- schemas below are automatically loaded, but added
          -- them here so that they show up in the statusline
          {
            name = 'kustomization.yaml',
            uri = 'https://json.schemastore.org/kustomization.json',
          },
          {
            name = 'gitlab-ci',
            uri = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
          },
          {
            name = 'Helm Chart.yaml',
            uri = 'https://json.schemastore.org/chart.json',
          },
          {
            name = 'sqlc configuration',
            uri = 'https://json.schemastore.org/sqlc-2.0.json',
          },
        },

        lspconfig = {
          settings = {
            yaml = {
              validate = true,
              schemaStore = {
                enable = false,
                url = '',
              },
              -- schemas from store, matched by filename
              -- loaded automatically
              -- Taken from "https://www.schemastore.org/api/json/catalog.json"
              schemas = require('schemastore').yaml.schemas {
                select = {
                  'kustomization.yaml',
                  'gitlab-ci',
                  'Helm Chart.yaml',
                  'sqlc configuration',
                  'Ansible Execution Environment',
                  'Ansible Meta',
                  'Ansible Meta Runtime',
                  'Ansible Argument Specs',
                  'Ansible Requirements',
                  'Ansible Vars File',
                  'Ansible Tasks File',
                  'Ansible Playbook',
                  'Ansible Rulebook',
                  'Ansible Inventory',
                  'Ansible Collection Galaxy',
                  'Ansible-lint Configuration',
                  'Ansible Navigator Configuration',
                },
              },
            },
          },
        },
      }
      require('lspconfig')['yamlls'].setup(cfg)
      require('telescope').load_extension 'yaml_schema'

      vim.keymap.set('n', '<leader>ly', require('telescope').extensions.yaml_schema.yaml_schema, { desc = '[L]SP: [Y]AML SCHEMA' })
    end,
  },
}
