collection @instrument_rules
cache ['v3-instrument_rules', @instrument_rules]

attributes :id, :instrument_id, :deleted_at

node :rule_type do |ir|
  ir.rule.rule_type if ir.rule
end

node :rule_params do |ir|
  ir.rule.rule_params if ir.rule
end
