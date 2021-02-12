local helper = {}

--- Multiplies matrix by vertex.
-- @params matrix table: must be a 3x3.
-- @params vertex table: must be of size 3 (x,y,z)
function helper.matrix_vec_multiplication(matrix, vertex)
  local new_vertex = {}
  for i=1,3 do
      new_vertex[i] = vertex[1] * matrix[i][1] + vertex[2] * matrix[i][2] + vertex[3] * matrix[i][3]
  end
  return new_vertex
end

--- Multiplies matrix by vertex.
-- @params matrix table: must be a 3x3.
-- @params vertex table: a list of vertexes
--
-- |a b c|     |x|
-- |d e f|  *  |y|
-- |g h i|     |z|
-- is encoded as
-- {{a, b, c}, {d, e, f}, {g, h, i}}
function helper.apply_matrix_transformation_to_vertexes(matrix, vertexes)
  local new_vertexes = {}
  for i=1,#vertexes do
      table.insert(new_vertexes, helper.matrix_vec_multiplication(matrix, vertexes[i]))
  end
  return new_vertexes
end

function helper.rotate_vertexes_around_z(vertexes, angle)
  local sin, cos = math.sincos(angle)
  local matrix = {{cos, -sin, 0}, {sin, cos, 0}, {0, 0, 0}}
  return helper.apply_matrix_transformation_to_vertexes(matrix, vertexes)
end

return helper
